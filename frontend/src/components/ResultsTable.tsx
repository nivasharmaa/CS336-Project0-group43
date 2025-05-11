'use client';
import {
  Table,
  Thead,
  Tbody,
  Tr,
  Th,
  Td,
  TableContainer,
} from '@chakra-ui/react';

interface ResultsTableProps {
  data: Array<Record<string, string | number>>;
}

export default function ResultsTable({ data }: ResultsTableProps) {
  if (!data || data.length === 0) return null;
  const headers = Object.keys(data[0]);
  return (
    <TableContainer>
      <Table variant="striped" colorScheme="gray">
        <Thead>
          <Tr>
            {headers.map((key) => (
              <Th key={key}>{key.replace(/_/g, ' ')}</Th>
            ))}
          </Tr>
        </Thead>
        <Tbody>
          {data.map((row, idx) => (
            <Tr key={idx} _hover={{ bg: 'gray.100' }}>
              {headers.map((key) => (
                <Td key={key}>{row[key]}</Td>
              ))}
            </Tr>
          ))}
        </Tbody>
      </Table>
    </TableContainer>
  );
}