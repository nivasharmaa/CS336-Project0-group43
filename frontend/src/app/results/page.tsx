'use client';

import { useSearchParams } from 'next/navigation';
import { useEffect, useState } from 'react';
import QueryResult from '@/components/QueryResult';

interface ApiResponse {
  question: string;
  sql: string;
  results: Array<Record<string, string | number>>;
}

export default function ResultsPage() {
  const params = useSearchParams();
  const question = params.get('q') || '';

  const [data, setData] = useState<ApiResponse>({
    question,
    sql: '',
    results: [],
  });
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    if (!question) return;
    setLoading(true);
    fetch('/api/ask', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ question }),
    })
      .then((res) => res.json())
      .then((json: ApiResponse) => setData(json))
      .finally(() => setLoading(false));
  }, [question]);

  if (loading) return <div>Loading…</div>;

  return (
    <QueryResult
      question={data.question}
      sql={data.sql}
      results={data.results}
    />
  );
}
