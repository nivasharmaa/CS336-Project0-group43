'use client';
import { useState } from 'react';
import { useRouter } from 'next/navigation';
import {
  Box,
  Button,
  Container,
  Heading,
  Input,
  Text,
  VStack,
} from '@chakra-ui/react';

export default function Home() {
  const [question, setQuestion] = useState('');
  const router = useRouter();

  const handleSubmit = () => {
    const q = question.trim();
    if (!q) return;
    router.push(`/results?q=${encodeURIComponent(q)}`);
  };

  return (
    <Box
      bg="gray.50"
      minH="100vh"
      display="flex"
      alignItems="center"
      justifyContent="center"
      px={4}
    >
      <Container maxW="xl">
        <VStack spacing={10}>
          <Box textAlign="center">
            <Heading as="h2" size="2xl" fontWeight="extrabold">
              Welcome to The Query Pilot
            </Heading>
            <Text mt={2} fontSize="lg" color="gray.600">
              Ask your database anything!
            </Text>
          </Box>

          <Box
            w="100%"
            bg="white"
            p={{ base: 6, md: 8 }}
            rounded="2xl"
            boxShadow="xl"
          >
            <VStack spacing={4}>
              <Input
                size="lg"
                placeholder="e.g., What is the most common loan denial reason?"
                value={question}
                onChange={(e) => setQuestion(e.target.value)}
                onKeyDown={(e) => e.key === 'Enter' && handleSubmit()}
              />
              <Button
                size="lg"
                colorScheme="teal"
                w="full"
                onClick={handleSubmit}
                isDisabled={!question.trim()}
              >
                Query
              </Button>
            </VStack>
          </Box>
        </VStack>
      </Container>
    </Box>
  );
}
